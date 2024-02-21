// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:test_flutter_web/models/client.dart';
import 'package:test_flutter_web/models/glass.dart';
import 'package:test_flutter_web/models/profile.dart';

class DefaultSearchBar extends StatelessWidget {
  final List<Client>? clientList;
  final List<Glass>? glassList;
  final List<Profile>? profileList;
  final void Function(String value)? onChanged;
  final bool showSuggestionList;
  final VoidCallback onTap;
  final String label;

  const DefaultSearchBar({
    Key? key,
    this.clientList,
    this.glassList,
    this.profileList,
    required this.label,
    this.onChanged,
    required this.showSuggestionList,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (clientList != null) {
      return Column(
        children: [
          TextField(
            onTap: onTap,
            onChanged: onChanged,
            decoration: const InputDecoration(
              label: Text('Digite o CPF do cliente'),
            ),
          ),
          Visibility(
            visible: showSuggestionList,
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: clientList?.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(clientList?[index].cpf ?? ''),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }
    if (glassList != null) {
      return Column(
        children: [
          TextField(
            onTap: onTap,
            onChanged: onChanged,
            decoration: const InputDecoration(
              label: Text('Digite o vidro'),
            ),
          ),
          Visibility(
            visible: showSuggestionList,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: glassList?.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(glassList?[index].name ?? ''),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        TextField(
          onTap: onTap,
          onChanged: onChanged,
          decoration: const InputDecoration(
            label: Text('Digite o perfil'),
          ),
        ),
        Visibility(
          visible: showSuggestionList,
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: profileList?.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(profileList?[index].name ?? ''),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
