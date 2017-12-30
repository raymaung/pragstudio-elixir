defmodule Servy.HandlerTest do
  use ExUnit.Case

  alias Servy.Handler

  test "/wildthings" do
    request = """
    GET /wildthings HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """

    assert Handler.handle(request) == expected_response
  end

  test "/wildlife" do
    request = """
    GET /wildthings HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Bears, Lions, Tigers
    """

    assert Handler.handle(request) == expected_response
  end

  test "/bears" do
    request = """
    GET /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 25

    Teddy, Smokey, Paddington
    """

    assert Handler.handle(request) == expected_response
  end

  test "/about" do
    request = """
    GET /about HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 318

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
    GET /bears/1 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 6

    Bear 1
    """

    assert Handler.handle(request) == expected_response
  end

  test "invalid path" do
    request = """
    GET /bigfoot HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected_response = """
    HTTP/1.1 404 Not Found
    Content-Type: text/html
    Content-Length: 17

    No /bigfoot here!
    """

    assert Handler.handle(request) == expected_response
  end


  test "POST /bears" do
    request = """
    POST /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*
    Content-Type: application/x-www-form-urlencoded
    Content-Length: 21

    name=Baloo&type=Brown
    """

    expected_response = """
    HTTP/1.1 201 Created
    Content-Type: text/html
    Content-Length: 32

    Created a Brown bear named Baloo
    """

    assert Handler.handle(request) == expected_response
  end
end
