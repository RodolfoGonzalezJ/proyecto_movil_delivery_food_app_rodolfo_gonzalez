import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/screens/home/views/order.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/screens/home/views/profile.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/screens/home/views/wallet_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Rodolfo Gonzalez'),
            accountEmail: Text('rgonzalezjimenez8@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Text(
                  'R',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Profile()),
              );
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.creditcard),
            title: const Text('Billetera'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const WalletScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.cart),
            title: const Text('Mi cesta'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Order()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.arrow_right_to_line),
            title: const Text('Cerrar Sesion'),
            onTap: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
          )
        ],
      ),
    );
  }
}
