import '../models/client.dart';

class ClientRepository {
  final List<Client> _clients = <Client>[];

  List<Client> initClients() {
    _clients.addAll([
      Client(name: "Thalisson"),
      Client(name: "Lidia"),
      Client(name: "Igor"),
    ]);
    return _clients;
  }

  List<Client> addClient(Client client) {
    _clients.add(client);
    return _clients;
  }

  List<Client> removeClient(Client client) {
    _clients.remove(client);
    return _clients;
  }
}