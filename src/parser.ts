import wretch from 'wretch';
import fetch from 'node-fetch';
import * as fs from 'fs/promises';
import * as cheerio from 'cheerio';
import * as prompt from 'prompts';
import * as chalk from 'chalk';
import yargs from 'yargs';
import { hideBin } from 'yargs/helpers';

const argv = yargs(hideBin(process.argv))
  .option('function', {
    type: 'string'
  })
  .argv;

wretch().polyfills({ fetch });

const outputFile = './src/mtasa/server/Functions.hx';

function isCamelCase(str: string): boolean {
  return /^([a-z]+)(([A-Z]([a-z]+))+)$/.test(str);
}

function capitalize(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

async function getHaxeParamsString(params: string): Promise<string> {
  if (params.trim() === '') return '';
  const haxeParams = [];
  const regexp = /(\w+ \w+)/ig;
  const match = params.match(regexp);

  console.log(chalk.yellow(params));

  for (let i = 0; i < match.length; i++) {
    const param = match[i];
    const [paramType, paramName] = param.split(' ');
    const response = await prompt([
      {
        type: 'toggle',
        name: 'optional',
        active: 'yes',
        inactive: 'no',
        message: 'Is ' + chalk.yellow(paramName) + ' optional?'
      },
      {
        type: prev => prev ? 'text' : null,
        name: 'defaultValue',
        message: 'Provide default value'
      }
    ]);

    haxeParams.push(`${response.optional ? '?' : ''}${paramName}:${capitalize(paramType)}${response.defaultValue ? ` = ${response.defaultValue}` : ''}`);
  }

  return haxeParams.join(', ');
}

function getFunctionDescription($: cheerio.Root): string {
  const info = $('#mw-content-text p')
    .toArray()
    .slice(0, 2)
    .map(element => {
      return `${$(element).text().trim()}`;
    })
    .join('');
  const reguiredArguments = $('#Required_Arguments')
    .closest('h3')
    .next('ul')
    .find('li')
    .toArray()
    .map(element => `\t\t@param ${$(element).text().replace(':', '')}`);
  const optionalArguments = $('#Optional_Arguments')
    .closest('h3')
    .next('ul')
    .find('li')
    .toArray()
    .map(element => `\t\t@param ${$(element).text().replace(':', '')}`);
  const args = [...reguiredArguments, ...optionalArguments].join('\n');

  return `/**\n\t\t${info}\n\n${args}\n\t**/\n`;
}

function getFunctionSyntax($:cheerio.Root, side: 'server' | 'client'): string {
  let syntax = $('#Syntax')
    .closest('h2')
    .next('pre')
    .text()
    .trim();

  if (syntax === '') {
    syntax = $(`.${side}Content pre`)
    .text()
    .trim();
  }

  return syntax;
}

async function synchronizeFunctionDeclaration(functionName: string): Promise<void> {
  const regexp = /([\w]+) ([\w]+)\s?\((.*)\)/ig;
  const response: string = await wretch(`https://wiki.multitheftauto.com/wiki/${functionName}`)
    .get()
    .text();

  const $ = cheerio.load(response);
  const functionSyntax = getFunctionSyntax($, 'server');
  const [_, returnType, __, paramsString] = regexp.exec(functionSyntax);
  const params = await getHaxeParamsString(paramsString);
  const functionString = getFunctionDescription($)
    + `\tstatic function ${functionName}(${params}):${capitalize(returnType)};\n`;

  let content = (await fs.readFile(outputFile))
    .toString()
    .replace(`// [${functionName}]`, functionString);

  await fs.writeFile(outputFile, content);
}

async function synchronizeServerFunctions(): Promise<string[]> { 
  const functions: string[] = [];
  const response: string = await wretch('https://wiki.multitheftauto.com/wiki/Server_Scripting_Functions')
    .get()
    .text();

  const $ = cheerio.load(response);
  
  let content = 'package mtasa.server;\n\n';
  content += "@:native('_G')\n";
  content += 'extern class Functions {\n';

  $('ul li a')
    .filter((i, element) => isCamelCase($(element).text()))
    .each((i, element) => {
      const functionName = $(element).text();

      if (!content.includes(functionName)) {
        functions.push(functionName);
        content += `\t// [${functionName}]\n`;
      }
    });

  content += '}';

  await fs.writeFile(outputFile, content);

  return functions;
}

(async () => {
  // await synchronizeServerFunctions();
  await synchronizeFunctionDeclaration(argv.function);
})();
