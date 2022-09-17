import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Pizza extends Equatable {
  final String? id;
  final String? name;
  final Image? image;

  const Pizza({
    this.id,
    this.image,
    this.name,
  }) : super();

  @override
  List<Object?> get props => [id, image, name];

  static List<Pizza?> pizza = [
    Pizza(
      id: "0",
      name: "Pizza",
      image: Image.asset("images/pizza.png"),
    ),
    Pizza(
      id: "1",
      name: "Pizza Pepperoni",
      image: Image.asset("images/pep.png"),
    ),
  ];
}
