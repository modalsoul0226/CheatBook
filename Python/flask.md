### Why `Flask` ?
Flask was designed from the start to be **extended**. It comes with a robust core that includes the basic functionality that all web applications need and expects the rest to be provided by some of the many third-party extensions in the ecosystem. So, you have the freedom to choose the component of your project.

### Initialization
```python
from flask import flask
app = Flask(__name__)
```
Here, `Flask` uses the `__name__` argument to determine the root path of the application so that it later can find resource files relative to the location of the application.

### Routes and View Functions
The association between a URL and the function that handles it is called a `route`.

> **Decorators** are a standard feature of the Python language; they can modify the behavior of a function in different ways. A common pattern is to use decorators to **register functions as handlers for an event**.

Example route:
```python
@app.route('/user/<name>') 
def user(name):
    return '<h1>Hello, %s!</h1>' % name
```
Here, `<name>` is a dynamic component in the route. The dynamic components in routes are strings by default but can also be defined with a type. For example, route `/user/<int:id>` would match only URLs that have an integer in the id dynamic segment. Flask supports types `int`, `float`, and `path` for routes.

Functions like `user()` are called **view functions**. The return value of this function, called the **response**, is what the client receives. If the client is a web browser, the response is the document that is displayed to the user.

### Server Startup
```python
if __name__ == '__main__': 
    app.run(debug=True)
```
The `__name__ == '__main__'` Python idiom is used here to ensure that the development web server is started only when the script is executed directly. 

Once the server starts up, it goes into a loop that waits for requests and services them.

### Application and Request Contexts
To avoid cluttering view functions with lots of arguments that may or may not be needed, Flask uses 
**contexts** to temporarily make certain objects globally accessible.

Flask activates (or **pushes**) the **application** and **request contexts** before dispatching a request and then removes them when the request is handled. If any of these variables are accessed without an active application or request context, an error is generated. 

### Request Dispatching
When the application receives a request from a client, `Flask` looks up the URL given in the request in the application’s **URL map**, which contains a mapping of URLs to the view functions that handle them.

### Request Hooks
At the start of each request, it may be necessary to create a database connection, or authenticate the user making the request. Instead of duplicating the code that does this in every view function, `Flask` gives you the option to register common functions to be invoked before or after a request is dispatched to a view function.

Request hooks are implemented as decoratros:
- `before_first_request`: register a function to run before the first request is handled.
- `before_request`: register a function to run before each request.
- `after_request`: register a function to run after each request if no unhandled exceptions occurred.
- `teardown_request`: register a function to run after each request, even if unhandled exceptions occured.

A common pattern to share data between request hook functions and view functions is to use the `g` context global (e.g. a `before_request` handler stores a user's info in `g.user` for a view function to access later).

### Responses