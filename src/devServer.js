console.log("DEV: Running node app!");
console.log(process.env);
setInterval(() => {
	console.log("DEV: Node app is still running! Waiting 10 seconds...");
}, 10000);