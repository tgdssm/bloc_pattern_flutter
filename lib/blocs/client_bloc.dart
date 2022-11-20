import 'dart:async';
import 'package:bloc/blocs/client_event.dart';
import 'package:bloc/blocs/client_state.dart';
import 'package:bloc/repositories/client_repository.dart';
import '../models/client.dart';

class ClientBloc {
  final _clientRepository = ClientRepository();

  final StreamController<ClientEvent> _inputClientController = StreamController<ClientEvent>();
  final StreamController<ClientState> _outputClientController = StreamController<ClientState>();

  Sink<ClientEvent> get inputClient => _inputClientController.sink;
  Stream<ClientState> get stream => _outputClientController.stream;

  ClientBloc() {
    _inputClientController.stream.listen(_mapEventToState);
  }

  _mapEventToState(ClientEvent event) async {
    List<Client> clients = [];
    if(event is LoadClientEvent) {
      clients = await _clientRepository.initClients();
    } else if(event is AddClientEvent) {
      clients = await _clientRepository.addClient(event.client);
    } else if(event is RemoveClientEvent) {
      clients = await _clientRepository.removeClient(event.client);
    }

    _outputClientController.add(ClientSuccessState(clients: clients));
  }

}