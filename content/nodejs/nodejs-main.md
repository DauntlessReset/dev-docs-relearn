---
title: NodeJS Main
description: NodeJS note derived from NodeJS - Novice to Ninja
---

```node -v``` - Check installed NodeJS version

```npm -v``` - Check Node Package Manager version

```
const name = 'Giles';
```

```
`Hello ${name};
```

Ctl + C to exit the read-evaluate-print loop (REPL) console. 

### Your First Console App

The ```process.argv``` property in the standard library returns an array containing the command line arguments:

- The first element (0) is the ```node``` command itself
- The second element (1) is the script you're running (```hello.js```)
- The third element (2) is the first argument passed

The below program will take the first argument passed and use it as the name argument within the console log statement. If no argument is provided, it will fall back to the environment USER variable. If this does not work it will simply use the hard-coded string `world`. 

```
#!/user/bin/env node

// fetch name from argument, or fallback on to default value
const nameArg = capitalize(process.argv[2] || process.env.USER || `world`);

// output message
console.log(`Hello ${nameArg}`)

// take the given string and returns the first word with the initial letter capitalized
function capitalize(str) {
    return str
        .trim()
        .toLowerCase()
        .split(' ')
        .map(word => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ');
}
```

```node program.js``` - Run program from the command line. 

Note: If shebang is included (```#!/usr/bin/env node```) and permissions are set (```chmod +x ./hello.js```) the program can be run without the ```node``` command (```./hello.js```).

### Your First Web Server App

This app:
- Defines a variable for the server's port. This can be a command line argument, a ```PORT``` environment variable, or by default ```3000```.
- It uses the HTTP createServer library to create a webserver that listens on the given port. When its callback function receives a request, it can examine the details in the ```req``` object and return a response using the ```res``` object. 

```
#!/usr/bin/env node

const
  port = (process.argv[2] || process.env.PORT || 3000),
  http = require('http');

http.createServer((req, res) => {

  console.log(req.url);

  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/html');
  res.end(`<p>Hello World!</p>`);

}).listen(port);

console.log(`Server running at http://localhost:${ port }/`);
```

Run with ```node webhello.js``` and open the server at ```http://localhost:3000/```.

### Restarting Node.js Applications with Nodemon

Restarting a Node.js application every time you make a change can become time consuming. 

Nodemon is a utility that monitors your source files for changes and automatically restarts the application. Use it in place of ```node``` to launch any Node.js application:

```nodemon webhello.js```

Saving a code change results in Nodemon restarting the application and printing a log entry to the terminal. If this doesn't watch, try using the ```-L``` flag (```--legacy-watch```).

### Writing Stateless Applications

It is recommended to make your application stateless to ensure that it can scale and be more resilient. Always assume:
- multiple instances could be running anywhere, possible on different ports or servers
- an instance can be started or stopped at any time
- a frontend web server will direct a single user's request to any instance - regardless of which instance handled a previous request 

Essentially, avoid storing application or user state in variables or local files that could differ across instances, instead using a database to retain state so that every instance of the application can be synchronized. 

### How to Debug Node.js Scripts 

Recommendations:

1. Use a good code editor (e.g. VSCode)

2. Use a code linter (e.g. ESLINT) - these can also be installed as VSCode extensions

3. Use source control (Git)

4. Adopt an issue-tracking system 

5. Use test-driven development

#### Environment Variables

Setting environment variables:

```
NODE_ENV=development
```

Internally, your own application can detect the setting and enable debugging message when necessary:
```
// running in development mode?
const DEVMODE = (process.env.NODE_ENV !== 'production');

if (DEVMODE) {
    console.log('application started in development mode');
}

```

#### Command-line Options

These options can be passed to the ```node``` command at the CLI:

```--trace-warnings``` - outputs stack traces when promises don't resolve or reject as expected

```--enable-source-maps``` - enable source maps when using a transpiler such as TypeScript

```--throw-deprecation``` - throw errors when deprecated features are used

```--inspect``` - activate the V8 inspector 

#### Console Debugging

While frowned upon by many, console debugging is often useful:

```console.log(myVariable)```

The ```console``` option offers many more possibilities:

![my image](/images/consoleoptions.png)

#### util.debuglog

The Node.js ```util``` module offers a built-in ```debuglog``` method that conditionally writes log messages to ```STDERR```:

```
const util = require('util');
const debuglog = util.debuglog('myapp');

debuglog('myapp debug message [%d]', 123);
```

Set the ```NODE_DEBUG``` environment variable to ```myapp``` (or a wildcard such as ```*``` or ```my*```) to display debugging messages on the console. 

```MYAPP 9876: myapp debug message [123]```

Note that 9876 is the Node.js process ID. 

#### Node.js V8 Inspector with Chrome

```node --inspect webhello.js``` - you can also use ```nodemon```

Open the page ```chrome://inspect``` in the address bar. Click on the Target's **inspect** link to launch DevTools. 

#### Debugging with VS Code 

Simply activate the **Run and Debug** pane, click the **Run and Debug Node.js** button, and choose the Node.js environment. 

### Debugging Terminology

| Term | Explanation |
|---|---|
| breakpoint | a line at which a debugger halts a program so its state can be inspected |
| breakpoint (conditional) | a breakpoint triggered by a certain condition, such as a value reaching 100. Also known as a watchpoint |
| debugger | a tool that offers debugging facilities such as running code line by line to inspect internal variable states |
| duplication | a reported bug that has already been reported—perhaps in a different way |
| feature | as in the claim: “it’s not a bug, it’s a feature”. You’ll find yourself saying this at some point |
| frequency | how often a bug occurs |
| it doesn’t work | the most-often made but least useful bug report |
| logpoint | a debugger instruction that shows the value of an expression during execution |
| logging | output of runtime information to the console or a file |
| logic error | the program works but doesn’t act as intended |
| priority | where a bug is allocated on a list of planned updates |
| race condition | hard-to-trace bugs dependent the sequence or timing of uncontrollable events |
| refactoring | rewriting code to help readability and maintenance |
| regression | re-emergence of a previously fixed bug perhaps owing to other updates |
| related | a bug that’s similar or related to another |
| reproduce | the steps required to cause the error |
| RTFM error | user incompetence disguised as a bug report, typically followed by a developer’s response that they should “Read The Friendly Manual” |
| step into | when running code line by line in a debugger, step into the function being called |
| step out | when running line by line, complete execution of the current function and return to the calling code |
| step over | when running line by line, complete execution of a command without stepping into a function it calls |
| severity | the impact of a bug on system. For example, data loss would normally be considered more problematic than a one-pixel UI alignment issue unless the frequency of occurrence is very low |
| stack trace | the historical list of all functions called before the error occurred |
| syntax error | typographical errors, such as console.lug() |
| user error | an error caused by a user rather than the application. This may still incur an update, depending on the seniority of the person who caused it! |
| watch | a variable or expression output during debugger execution |