+++
title = "First Look at TeaVM: Java on the Browser?"
date = 2019-08-03T20:00:40-04:00
description = "A young upstart named TeaVM attempts to challenge bloated JavaScript web frameworks. Can it succeed?"
draft = false
toc = false
categories = []
tags = ["tech", "knoweth"]
images = []
+++

Recently, as part of work on [Knoweth][knoweth github] (an Anki-esque spaced-repetition flashcard reviewer; see [my friend's blog][kunal redesign post] for more information), I have been experimenting with some lesser-used web technology: [TeaVM][teavm homepage], an ahead-of-time compiler that converts Java bytecode to JavaScript or WebAssembly.

This technology, to put it mildly, is ridiculously impressive. To be clear, this isn't "I compiled the entire Java Virtual Machine to WebAssembly; please wait for my hundred-megabyte download" (although [that also exists][cheerpj]); this compiles your Java code straight to JS, only including the minimum standard library required. `System.out.println`? More like `console.log`. Some more features:

- It reimplements a good subset of the Java standard library so it can be compiled to JavaScript
- Through [Flavour][flavour], it has a full-on single-page-application/HTML templating framework, supporting REST, routing, and custom components
- It has a [libgdx backend][libgdx] to run libgdx applications on the browser
- It's ridiculously lean

So considering the sizable proportion of developers who [hate JavaScript][cancer] with a burning passion (for entirely understandable reasons), can TeaVM offer a compelling alternative?

## Trying it Out

Let's try it out:

```
$ mvn compile
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 5.393 s
[INFO] Finished at: 2019-08-04T19:12:03-04:00
[INFO] Final Memory: 23M/39M
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.teavm:teavm-maven-plugin:0.5.1:compile (default-cli) on project knoweth: Unexpected error occured: ConcurrentModificationException -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
```

(Elided are hours of me trying to figure out how Maven works, since I've never used it before. I won't count that against TeaVM. If you're stuck, my understanding is that teavm's maven plugin runs by default in the `package` phase? So running `mvn compile` actually won't run it by default.)

I'll save you the [Googling](https://github.com/konsoletyper/teavm/issues/363) and just say that TeaVM 0.5.1 (the latest stable release) is incompatible with Java 11, which I am using. The solution is to use their development `0.6.0-dev-*` versions from bintray. Fine - it would have been nice if TeaVM had a stable release for Java 11 (and it should be better documented), but it works. 

## REST Client Issues

Here is some code that will call a `/login` endpoint with a JSON body of `{ "username": "bob", "password": "bob" }`:

```java
@Path("")
public interface UserService {
    @Path("login")
    @POST
    void login(LoginBody body);
}

...

UserService r = RESTClient.factory(UserService.class).createResource("");
BackgroundWorker worker = new BackgroundWorker();
worker.run(() -> {
    try {
        // Should make a POST request to /login with JSON body
        r.login(new LoginBody("bob", "bob"));
    } catch (Exception e) {
        e.printStackTrace();
    }
});
```

Issue #1 is that you _need_ to make the login request from a `BackgroundWorker`, a class that Flavour uses to run background methods and update bound templates afterward, leveraging TeaVM's async support. (That's right: TeaVM added green threads to Java. In JavaScript.) This is not documented on their [REST client docs][] (although it is on their [advanced UI components page][]); I only figured it out by coming across a chance Google Groups post. 

The second issue is this one:

![fetch request fails with Java exception thrown](/images/2019-07-22-knoweth-teavm-first-look/java-exception-thrown.png)

An error whose undescriptiveness rivals babel-transpiled asynchronous JavaScript code. The core issue is actually _not_ a Java exception; rather, it's a JavaScript error from within standard library `RequestImpl` code, hence why it provides no description of what the error is. The REST client attempts, in 0.6.0-dev-816, to call a JS function that does not exist (`otfri_RequestImpl_send0`), and it fails with the JavaScript error `otfri_RequestImpl_send0 is not defined`. The only way I've been able to fix this is to roll back to Java 8 + TeaVM 0.5.1, which fixes the problem. (Issue reference: [#407](https://github.com/konsoletyper/teavm/issues/407).)

As a whole, there also doesn't appear to be a way to make low-level HTTP requests (e.g. setting headers) other than by writing JavaScript bindings in Java (which is also woefully underdocumented.)

## In Summary

You may have seen a theme here. TeaVM is incredibe technology, but it is unfortunately extremely underdocumented, likely due to having less real-world usage than most frameworks. You will find almost nothing on StackOverflow or blog posts about it; your best recourse is typically reading the source code.

I would still recommend you try it out, though! And perhaps file a few issues, or write some documentation. When it works, it is amazing to use.

(Disclaimer: this is a _first look_. If any experienced TeaVM users would like to chime in with corrections or advice, please do so in the comments!)

[knoweth github]: https://github.com/knoweth/knoweth
[kunal redesign post]: https://insensitive.co/posts/2019/03/anki-redesign-and-development-part-1/
[teavm homepage]: http://teavm.org
[cheerpj]: https://www.leaningtech.com/cheerpj/
[flavour]: http://teavm.org/docs/flavour/templates.html
[libgdx]: https://stackoverflow.com/questions/42466164/how-i-deploy-my-libgdx-project-to-html-js-using-teavm
[cancer]: https://www.semitwist.com/mirror/node-js-is-cancer.html
[REST client docs]: http://teavm.org/docs/flavour/rest-client.html
[advanced UI components page]: http://teavm.org/docs/flavour/advanced-ui-components.html