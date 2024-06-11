import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/components/shared_pref.dart';
import 'package:user_repository/user_repository.dart';

import '../../../components/macro.dart';

class DetailsScreen extends StatefulWidget {
  final Pizza pizza;
  const DetailsScreen(this.pizza, {super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int a = 1, total = 0;
  String? id;

  getTheSharedPref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  onTheLoad() async {
    await getTheSharedPref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    onTheLoad();
    total = (widget.pizza.price -
            (widget.pizza.price * (widget.pizza.discount) / 100))
        .round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(3, 3), blurRadius: 5)
                ],
              ),
              child: Column(
                children: [
                  Image.network(widget.pizza.picture),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.pizza.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${(widget.pizza.price - (widget.pizza.price * (widget.pizza.discount) / 100)).round()}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                Text(
                                  "\$${widget.pizza.price}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      children: [
                        MyMacroWidget(
                            title: 'Calorias',
                            value: widget.pizza.macros.calories,
                            icon: FontAwesomeIcons.fire),
                        const SizedBox(
                          width: 10,
                        ),
                        MyMacroWidget(
                            title: 'Proteina',
                            value: widget.pizza.macros.proteins,
                            icon: FontAwesomeIcons.dumbbell),
                        const SizedBox(
                          width: 10,
                        ),
                        MyMacroWidget(
                            title: 'Grasas',
                            value: widget.pizza.macros.fat,
                            icon: FontAwesomeIcons.oilWell),
                        const SizedBox(
                          width: 10,
                        ),
                        MyMacroWidget(
                            title: 'Carbohidratos',
                            value: widget.pizza.macros.carbs,
                            icon: FontAwesomeIcons.breadSlice),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(3, 3), blurRadius: 5)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 28,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (a > 1) {
                                --a;
                                total = total -
                                    (widget.pizza.price -
                                            (widget.pizza.price *
                                                (widget.pizza.discount) /
                                                100))
                                        .round();
                              }
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(a.toString(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              ++a;
                              total = total +
                                  (widget.pizza.price -
                                          (widget.pizza.price *
                                              (widget.pizza.discount) /
                                              100))
                                      .round();
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Total: $total",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          Map<String, dynamic> addFoodToCart = {
                            "Name": widget.pizza.name,
                            "Quantity": a.toString(),
                            "Total": total.toString(),
                            "Image": widget.pizza.picture
                          };
                          await FirebaseUserRepo()
                              .addFoodToCart(addFoodToCart, id!);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Se ha añadido a la cesta'),
                          ));
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.onBackground,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Añadir a la cesta',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
