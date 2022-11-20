import '../models/client.dart';

class ClientRepository {
  final List<Client> _clients = <Client>[];

  Future<List<Client>> initClients() async {
    _clients.addAll([
      Client(name: "Thalisson"),
      Client(name: "Lidia"),
      Client(name: "Igor"),
    ]);
    await Future.delayed(const Duration(seconds: 2));
    return _clients;
  }

  Future<List<Client>> addClient(Client client) async{
    _clients.add(client);
    await Future.delayed(const Duration(seconds: 2));
    return _clients;
  }

  Future<List<Client>> removeClient(Client client) async {
    _clients.remove(client);
    await Future.delayed(const Duration(seconds: 2));
    return _clients;
  }
}