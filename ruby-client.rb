require 'net/https'
require 'json'

BASE_HOST = 'www.courtlistener.com'
API_PATH = '/api/rest/v3/'
DOCKETS_PATH = API_PATH + 'dockets/'


def get_results(path, query = nil)
  query_string = URI.encode_www_form(query)
  uri = URI::HTTP.build(scheme: 'https', host: BASE_HOST, path: path, query: query_string)
  uri.scheme = 'https'
  uri.port = 443

  req = Net::HTTP::Get.new(uri)
  req.basic_auth 'neweraadrapi', 'Z58YCLBdarqaYNK'

  res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end

  response = JSON.parse(res.body)

  response['results']
end

data = get_results(DOCKETS_PATH, {
  nature_of_suit: '840 Trademark',
  'date_created__lte' => '2020-07-25T00:00:00Z',
  'date_created__gte' => '2019-01-01T00:00:00Z'
})
