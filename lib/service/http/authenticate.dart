import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/token.dart';

class Authenticate {
  final String domain;

  Authenticate(this.domain);

  Future<AuthToken> login(String login, String password) async {
    final response = await http.post(
      domain + '/authenticate',
      headers: {
        'Content-Type': 'application/json',
      },
      body: {login: login, password: password},
    );
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return AuthToken.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      return Future.error('Failed to load book');
    }
  }
  /*

    private autoAuth(url: string): Promise<boolean> {
      return this.authByToken(this.refresh_token).then((ret: boolean) => {
            if (!ret) {
                this.logout();
                this.router.navigate['/home'];
                return false;
            }
            this.router.navigateByUrl(url);
            return true;
        });
    }

    private authByToken(token: string): Promise<boolean> {
        return this.http
            .get(this.tokenUrl+"/auth", {headers: this.getTokenHeaders(token)})
            .toPromise()
            .then((response: Response) => this.initAuth(response))
            .catch(() => false);
    }

    login(login: string, password: string): Promise<boolean> {
        return this.http
            .post(this.authUrl, JSON.stringify({ login: login, password: password }), {headers: this.getHeaders()})
            .toPromise()
            .then((response: Response) => this.initAuth(response))
            .catch(this.handleError);
    }
*/
}
