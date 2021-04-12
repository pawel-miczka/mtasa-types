"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __spreadArray = (this && this.__spreadArray) || function (to, from) {
    for (var i = 0, il = from.length, j = to.length; i < il; i++, j++)
        to[j] = from[i];
    return to;
};
exports.__esModule = true;
var wretch_1 = require("wretch");
var node_fetch_1 = require("node-fetch");
var fs = require("fs/promises");
var cheerio = require("cheerio");
var prompt = require("prompts");
var chalk = require("chalk");
var yargs_1 = require("yargs");
var helpers_1 = require("yargs/helpers");
var argv = yargs_1["default"](helpers_1.hideBin(process.argv))
    .option('function', {
    type: 'string'
})
    .argv;
wretch_1["default"]().polyfills({ fetch: node_fetch_1["default"] });
var outputFile = './src/mtasa/server/Functions.hx';
function isCamelCase(str) {
    return /^([a-z]+)(([A-Z]([a-z]+))+)$/.test(str);
}
function capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}
function getHaxeParamsString(params) {
    return __awaiter(this, void 0, void 0, function () {
        var haxeParams, regexp, match, i, param, _a, paramType, paramName, response;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0:
                    if (params.trim() === '')
                        return [2 /*return*/, ''];
                    haxeParams = [];
                    regexp = /(\w+ \w+)/ig;
                    match = params.match(regexp);
                    console.log(chalk.yellow(params));
                    i = 0;
                    _b.label = 1;
                case 1:
                    if (!(i < match.length)) return [3 /*break*/, 4];
                    param = match[i];
                    _a = param.split(' '), paramType = _a[0], paramName = _a[1];
                    return [4 /*yield*/, prompt([
                            {
                                type: 'toggle',
                                name: 'optional',
                                message: 'Is ' + chalk.yellow(paramName) + ' optional?'
                            },
                            {
                                type: function (prev) { return prev ? 'text' : null; },
                                name: 'defaultValue',
                                message: 'Provide default value'
                            }
                        ])];
                case 2:
                    response = _b.sent();
                    haxeParams.push("" + (response.optional ? '?' : '') + paramName + ":" + capitalize(paramType) + (response.defaultValue ? " = " + response.defaultValue : ''));
                    _b.label = 3;
                case 3:
                    i++;
                    return [3 /*break*/, 1];
                case 4: return [2 /*return*/, haxeParams.join(', ')];
            }
        });
    });
}
function getFunctionDescription($) {
    var info = $('#mw-content-text p')
        .toArray()
        .slice(0, 2)
        .map(function (element) {
        return "" + $(element).text().trim();
    })
        .join('');
    var reguiredArguments = $('#Required_Arguments')
        .closest('h3')
        .next('ul')
        .find('li')
        .toArray()
        .map(function (element) { return "\t\t@param " + $(element).text().replace(':', ''); });
    var optionalArguments = $('#Optional_Arguments')
        .closest('h3')
        .next('ul')
        .find('li')
        .toArray()
        .map(function (element) { return "\t\t@param " + $(element).text().replace(':', ''); });
    var args = __spreadArray(__spreadArray([], reguiredArguments), optionalArguments).join('\n');
    return "/**\n\t\t" + info + "\n\n" + args + "\n\t**/\n";
}
function getFunctionSyntax($, side) {
    var syntax = $('#Syntax')
        .closest('h2')
        .next('pre')
        .text()
        .trim();
    if (syntax === '') {
        syntax = $("." + side + "Content pre")
            .text()
            .trim();
    }
    return syntax;
}
function synchronizeFunctionDeclaration(functionName) {
    return __awaiter(this, void 0, void 0, function () {
        var regexp, response, $, functionSyntax, _a, _, returnType, __, paramsString, params, functionString, content;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0:
                    regexp = /([\w]+) ([\w]+)\s?\((.*)\)/ig;
                    return [4 /*yield*/, wretch_1["default"]("https://wiki.multitheftauto.com/wiki/" + functionName)
                            .get()
                            .text()];
                case 1:
                    response = _b.sent();
                    $ = cheerio.load(response);
                    functionSyntax = getFunctionSyntax($, 'server');
                    _a = regexp.exec(functionSyntax), _ = _a[0], returnType = _a[1], __ = _a[2], paramsString = _a[3];
                    return [4 /*yield*/, getHaxeParamsString(paramsString)];
                case 2:
                    params = _b.sent();
                    functionString = getFunctionDescription($)
                        + ("\tstatic function " + functionName + "(" + params + "):" + capitalize(returnType) + ";\n");
                    return [4 /*yield*/, fs.readFile(outputFile)];
                case 3:
                    content = (_b.sent())
                        .toString()
                        .replace("// [" + functionName + "]", functionString);
                    return [4 /*yield*/, fs.writeFile(outputFile, content)];
                case 4:
                    _b.sent();
                    return [2 /*return*/];
            }
        });
    });
}
function synchronizeServerFunctions() {
    return __awaiter(this, void 0, void 0, function () {
        var functions, response, $, content;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    functions = [];
                    return [4 /*yield*/, wretch_1["default"]('https://wiki.multitheftauto.com/wiki/Server_Scripting_Functions')
                            .get()
                            .text()];
                case 1:
                    response = _a.sent();
                    $ = cheerio.load(response);
                    content = 'package mtasa.server;\n\n';
                    content += "@:native('_G')\n";
                    content += 'extern class Functions {\n';
                    $('ul li a')
                        .filter(function (i, element) { return isCamelCase($(element).text()); })
                        .each(function (i, element) {
                        var functionName = $(element).text();
                        if (!content.includes(functionName)) {
                            functions.push(functionName);
                            content += "\t// [" + functionName + "]\n";
                        }
                    });
                    content += '}';
                    return [4 /*yield*/, fs.writeFile(outputFile, content)];
                case 2:
                    _a.sent();
                    return [2 /*return*/, functions];
            }
        });
    });
}
(function () { return __awaiter(void 0, void 0, void 0, function () {
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0: 
            // await synchronizeServerFunctions();
            return [4 /*yield*/, synchronizeFunctionDeclaration(argv["function"])];
            case 1:
                // await synchronizeServerFunctions();
                _a.sent();
                return [2 /*return*/];
        }
    });
}); })();
