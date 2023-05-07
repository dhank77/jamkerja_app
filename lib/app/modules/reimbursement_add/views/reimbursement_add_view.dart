import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jamkerja/app/component/app_bar.dart';
import 'package:jamkerja/app/form/button.dart';
import 'package:jamkerja/app/form/form_input.dart';
import 'package:jamkerja/app/form/form_select.dart';

import '../controllers/reimbursement_add_controller.dart';

class ReimbursementAddView extends GetView<ReimbursementAddController> {
  const ReimbursementAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Container(
        color: Colors.amber[50],
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => controller.list.isNotEmpty
                  ? FormSelect(
                      label: "Pilih Pengajuan",
                      listData: controller.list.map((item) {
                        return DropdownMenuItem(
                          child: Text(item['label']),
                          value: item['kode_reimbursement'],
                        );
                      }).toList(),
                      icon: Icons.outbox_rounded,
                      initialValue: controller.kodeReimbursement.value,
                      onChanged: (value) {
                        controller.kodeReimbursement.value = value.toString();
                      },
                    )
                  // ? Text(controller.list.toString())
                  : const SizedBox(),
            ),
            FormInput(
              control: controller.nilai,
              title: "Nominal",
              keyboard: TextInputType.number,
              icon: Icons.attach_money_sharp,
            ),
            FormInput(
              control: controller.keterangan,
              title: "Keterangan",
              icon: Icons.message,
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Button(
                fnc: () => controller.sendData(),
                animate: controller.animate.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
