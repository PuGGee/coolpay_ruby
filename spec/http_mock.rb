require 'json'

class HttpMock

  def initialize(response)
    @response = response
  end

  def get(*args)
    mock(*args)
  end

  def post(*args)
    mock(*args)
  end

  private

  def mock(relative_path, headers: {}, body: '')
    return @response
  end
end
