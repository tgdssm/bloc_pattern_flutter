import 'package:bloc/blocs/client_bloc.dart';
import 'package:bloc/blocs/client_event.dart';
import 'package:bloc/blocs/client_state.dart';
import 'package:bloc/models/client.dart';
import 'package:flutter/material.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late final ClientBloc bloc;

  @override
  void initState() {
    bloc = ClientBloc();
    bloc.inputClient.add(LoadClientEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.inputClient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clients"),
        actions: [IconButton(onPressed: (){
          bloc.inputClient.add(AddClientEvent(client: Client(name: "Teste bloc")));
        }, icon: const Icon(Icons.add))],
      ),
      body: StreamBuilder<ClientState>(
        stream: bloc.stream,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          final clients = snapshot.data?.clients ?? [];
          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(clients[index].name),
                  const Spacer(),
                  IconButton(onPressed: (){
                    bloc.inputClient.add(RemoveClientEvent(client: clients[index]));
                  }, icon: const Icon(Icons.remove)),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
