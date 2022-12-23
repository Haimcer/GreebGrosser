import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrosser/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrosser/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrosser/src/config/app_data.dart' as appData;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
              onPressed: () {
                authController.signOut();
              },
              icon: const Icon(
                Icons.logout,
              )),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //todo Email

          CustomTextField(
            readOnly: true,
            initialValue: appData.user.email,
            icon: Icons.email,
            label: 'Email',
          ),

          //todo Nome

          CustomTextField(
            readOnly: true,
            initialValue: appData.user.name,
            icon: Icons.person,
            label: 'Nome',
          ),

          //todo Celular

          CustomTextField(
            readOnly: true,
            initialValue: appData.user.phone,
            icon: Icons.phone,
            label: 'Celular',
          ),

          //todo CPF

          CustomTextField(
            readOnly: true,
            initialValue: appData.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
          ),

          //todo Botão para atualizar a senha

          SizedBox(
            height: 50,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.green,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  updatePassword();
                },
                child: const Text('Atualizar senha')),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //todo Titulo

                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Text(
                          'Atualização de senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //todo Senha atual

                      const CustomTextField(
                          isSecret: true,
                          icon: Icons.lock,
                          label: 'Senha atual'),

                      //todo Nova senha

                      const CustomTextField(
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: 'Nova senha'),

                      //todo Confirmação nova senha

                      const CustomTextField(
                          isSecret: true,
                          icon: Icons.lock_outline,
                          label: 'Confirmar nova senha'),

                      //todo Botão de confirmação

                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                          onPressed: () {},
                          child: const Text('Atualizar'),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
