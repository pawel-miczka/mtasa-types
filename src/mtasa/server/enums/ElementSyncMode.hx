package mtasa.server.enums;

@:enum abstract ElementSyncMode(String) {
	var BROADCAST = 'broadcast';
	var LOCAL = 'local';
	var SUBSCRIBE = 'subscribe';
}
