# ExApiGateway

Plugの機能をためしてみる。path と host でマッチングして分岐できるっぽい。

## サーバー起動

```sh
mix server
```

## リクエスト例

### ping
```sh
$ curl "http://localhost:4000/ping"
Pong localhost

$ curl -H "host: jp-east-1.computing.api.nifcloud.com" "http://localhost:4000/ping"
Pong computing

$ curl -H "host: api.github.com" "http://localhost:4000/ping"
Pong github

$ curl -H "host: example.com" "http://localhost:4000/ping"
No matching host, example.com⏎
```

### nifcloud
```sh
$ curl -H "host: jp-east-1.computing.api.nifcloud.com" "http://localhost:4000/api/?Action=XXXX"
<Response><Errors><Error><Code>Client.AuthFailureRequired.AccessKey</Code><Message>No access key was provided.</Message></Error></Errors><RequestID>xxxx</RequestID></Response>⏎
```

### github
```sh
$ curl -H "host: api.github.com" "http://localhost:4000/users"
[{"login":...}]
```
