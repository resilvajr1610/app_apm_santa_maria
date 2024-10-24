import 'package:googleapis_auth/auth_io.dart';

class GetServiceKey{
  Future <String> getServerKeyToken()async{
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
          {
          "type": "service_account",
          "project_id": "apm-santa-maria",
          "private_key_id": "1443b4024b5f902a9930611053013e34780be046",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCn5wu+QDGJRGus\nujf+V76S3+32DOhhoN5kab9qKW+zfPT829AUq9JgVmRfLdJ9Qb2NwCtJ30HZlYDh\nxmTFTbuNRYz8bJc/yBVQ5gohYdgy42kJdZw7ljPNC1U9yX1l0+d5VNVGhTDlr/kL\nEhTYKP+RLInFJPQjzSMAJFmgQVwu9wwR9XjyLwymt/dX2DC5q+jSqW/oUEZND65u\n5MpJs47JMIfmPvpOEuCXyCrjCpI/qobgdS05TqIkeqGzOoI526vE2AHd7g3P/nhq\ntUF5FPPG7NlsLOClkwxck2q29NPeDulUWVcbxvIbtIfEAJHLWO2UaZQ7Gtq3+xUI\nLDw+nsMLAgMBAAECggEAL1hHR25yiXJxqlMYVvAHHQNn5mndXSovi8EF6LmmdcZW\njratBictO10hEHWrVQaknMQDcOEzgFdX8FIxODGjIULrboJwY9vXpug3ExK0FCVs\nCO7RDzxbfwYjEzkt0vjd3Ki/OxNzplDouOZwWkO1TQpyDtVMwoulwvR9EWNcyyEJ\nqXjOIfiBDhvFDcuDB9EspCw+AAa3Ay4N/8U0UnnHkbvAMamq59KfgekbNWzcrHQw\nyHkw1rwxvV3FdHhIeH1s/WNnkG7tJ9UQLezPE0H+UPw00nT3pbr+NCHlsqPV4FnA\nRg6vdszHU0BaS8Lx9+FE0XbHT80LN799M+ca8DsngQKBgQDQfQyOybn5VPaXkPJt\nnB7PPeu+cUj+s0wmvUB29yjss0EsXmdFhzyZf32uE/AieD3Gn7+9Qp+l005PcE6a\nGAn2EekFXJZF7lUqND04MuiWTgdmcXQKZW6aAxhYY+PY8A1bXkRivZoT0WZ+9B98\njIZOFCCcCaOa/8Us4S6tkm1XhwKBgQDOKkOvDRphd+wbmXPTP9kP+ejiR083gVAJ\nYundhcSQo0xr99u+SWuQnkRSRgPMvakTozPeH0kiFgAsxbkxQ6YxAWPyQaQPYROV\nioOac1/D1LuzDaXba/3TcTIDog/BBbotGuOsQdtUNHos/naA0J7NyX0n+jdDMxNC\n+tLLvroRXQKBgFB6lOhhckqOw4mKSCqLg1EYY/HlpPm8mH6zuziw+7kzEMthvZeX\nNotCLW+O/rkvlRkg/VC/cQT/5lC/13egI+g6zapmLRPdhj5+X8tby3CJuk2PKe4B\nbYpB+5nTJVbOgzlr0BYVfm57/IaxEZ5wWD+3gUb6aY8hgCls2ynhRhftAoGBAJlW\nhhDkxgJIl6vPbn5otqFTVws1zo2R+F2C3D6PB6wsSOLk7uOQ6BggHuCygpD9X4vj\njuhejJ51jpu+VAd4MVuxlQzSFZv6r/5Bj7CIr2mQCCscs4eHwrpJLtHU77K498gk\nf8HXGbJ/dX+Ro8IbaIHWoufhCslIa8Mdmzs/GFVhAoGBAKLfieN2R/9zdDY3Rukx\nL8feK+JtHMcQkdbXCZOWxXi1gMcf2OJlySm9sQWvA07lblPh3eLUhorDF+B7x0K7\n9nbAjZYnDAO5SoTLWSujaIyT5EyTdxwo6eLdPO3Zw89d0rVN9zT3vbgMpVTu+hvX\nykZXUN9jHeruzaEPoLAr648F\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-15lfj@apm-santa-maria.iam.gserviceaccount.com",
          "client_id": "115921026615923901062",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-15lfj%40apm-santa-maria.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      ),
      scopes
    );
    final acessServerKey = client.credentials.accessToken.data;
    return acessServerKey;
  }
}