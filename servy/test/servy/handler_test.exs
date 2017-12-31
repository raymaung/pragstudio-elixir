defmodule Servy.HandlerTest do
  use ExUnit.Case

  alias Servy.Handler

  test "/wildthings" do
    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 20\r
    \r
    Bears, Lions, Tigers
    """

    assert Handler.handle(request) == expected_response
  end

  test "/wildlife" do
    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 20\r
    \r
    Bears, Lions, Tigers
    """

    assert Handler.handle(request) == expected_response
  end

  test "/bears" do
    request = """
    GET /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 341\r
    \r
    <h1>All The Bears</h1>
    <ul>

        <li> Brutus - Grizzly</li>

        <li> Iceman - Polar</li>

        <li> Kenai - Grizzly</li>

        <li> Paddington - Brown</li>

        <li> Roscoe - Panda</li>

        <li> Rosie - Black</li>

        <li> Scarface - Grizzly</li>

        <li> Smokey - Black</li>

        <li> Snow - Polar</li>

        <li> Teddy - Brown</li>

    </ul>
    """

    assert Handler.handle(request) == expected_response
  end

  test "/api/bears" do
    request = """
    GET /api/bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: application/json\r
    Content-Length: 605\r
    \r
    [{"type":"Brown","name":"Teddy","id":1,"hibernating":true},{"type":"Black","name":"Smokey","id":2,"hibernating":false},{"type":"Brown","name":"Paddington","id":3,"hibernating":false},{"type":"Grizzly","name":"Scarface","id":4,"hibernating":true},{"type":"Polar","name":"Snow","id":5,"hibernating":false},{"type":"Grizzly","name":"Brutus","id":6,"hibernating":false},{"type":"Black","name":"Rosie","id":7,"hibernating":true},{"type":"Panda","name":"Roscoe","id":8,"hibernating":false},{"type":"Polar","name":"Iceman","id":9,"hibernating":true},{"type":"Grizzly","name":"Kenai","id":10,"hibernating":false}]
    """

    assert Handler.handle(request) == expected_response
  end

  test "/about" do
    request = """
    GET /about HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 318\r
    \r
    <h1>Clark's Widthings Refuge</h1>

    <blockquote>
    When we contemplate the whole globe as one great dewdrop,
    striped and dotted with continents and islands, flying through
    space with other stars all singing and shining together as one,
    the whole universe appears as an infinite storm of beauty.
    -- John Muir
    </blockquote>
    """

    assert Handler.handle(request) == expected_response
  end

  test "/bears/1" do
    request = """
    GET /bears/1 HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 71\r
    \r
    <h1>Show Bear</h1>
    <p>
    Is Teddy hibernating? <strong>true</strong>
    </p>
    """

    assert Handler.handle(request) == expected_response
  end

  test "invalid path" do
    request = """
    GET /bigfoot HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    expected_response = """
    HTTP/1.1 404 Not Found\r
    Content-Type: text/html\r
    Content-Length: 17\r
    \r
    No /bigfoot here!
    """

    assert Handler.handle(request) == expected_response
  end

  test "POST /bears" do
    request = """
    POST /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    Content-Type: application/x-www-form-urlencoded\r
    Content-Length: 21\r
    \r
    name=Baloo&type=Brown\r
    """

    expected_response = """
    HTTP/1.1 201 Created\r
    Content-Type: text/html\r
    Content-Length: 32\r
    \r
    Created a Brown bear named Baloo
    """

    assert Handler.handle(request) == expected_response
  end
end
