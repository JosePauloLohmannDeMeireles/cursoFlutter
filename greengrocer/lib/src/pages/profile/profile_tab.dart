import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp( r'[0-9]' )}
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {'#': RegExp( r'[0-9]')}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Perfil do usuário',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.logout)
          )
        ],
      ),

      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
            initialValue: app_data.user.email,
            icon: Icons.email, 
            label: 'Email',
            readOnly: true,
          ),

          CustomTextField(
            initialValue: app_data.user.name,
            icon: Icons.person, 
            label: 'Nome',
            readOnly: true,
          ),

          CustomTextField(
            initialValue: app_data.user.phone,
            icon: Icons.phone, 
            label: 'Celular',
            inputFormatter: [phoneFormatter],
            readOnly: true,
          ),

          CustomTextField(
            initialValue: app_data.user.cpf,
            icon: Icons.file_copy, 
            label: 'CPF',
            inputFormatter: [cpfFormatter],
            isSecret: true,
            readOnly: true,
          ),
       

          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.green
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20)
                )              
              ),
              onPressed: () {
                updatePassord();
              },
              child: const Text(
                'Atualizar senha',
                style: TextStyle(
                  color: Colors.green
                ),
              ),
            ),
          ) 
        ],
      ),
    );
  }

  Future<bool?> updatePassord(){
    return showDialog(context: context, builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20)
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
              
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Atualização de Senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
              
                    const CustomTextField(icon: Icons.lock, label: 'Senha Atual', isSecret: true,),
                    const CustomTextField(icon: Icons.lock_outline, label: 'Nova Senha', isSecret: true,),
                    const CustomTextField(icon: Icons.lock_outline, label: 'Confirmar Nova Senha', isSecret: true,),
              
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green
                        ),
                        onPressed: () {}, 
                        child: const Text(
                          'Atualizar', 
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),

              Positioned(
                top: 5,
                right: 5,
                child: IconButton(onPressed: () {
                  Navigator.of(context).pop();
                }, icon: const Icon(Icons.close))
              
              )
            ],
          ),
        );
      }
    );
  }
}