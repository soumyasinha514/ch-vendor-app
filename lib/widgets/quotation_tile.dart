import 'package:bma_cars/widgets/client_profile.dart';
import 'package:flutter/material.dart';
import 'package:bma_cars/models/quotation.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bma_cars/providers/quotation_list_provider.dart';

class QuotationTile extends ConsumerStatefulWidget {
  final Quotation quotation;

  QuotationTile({required this.quotation});

  @override
  ConsumerState<QuotationTile> createState() => _QuotationTileState();
}

class _QuotationTileState extends ConsumerState<QuotationTile> {
  DateTime? _date;
  DateTime? _time;
  bool _isDateSelected = false;
  bool _isTimeSelected = false;
  List<Map<String, dynamic>> _rows = [];
  List<TextEditingController> _descControllers = [];
  List<TextEditingController> _amtControllers = [];

  void addRow() {
    setState(() {
      _rows.add({'desc': '', 'amt': 0.0});
      _descControllers.add(TextEditingController());
      _amtControllers.add(TextEditingController());
    });
  }

  double _calculateTotalAmount() {
    double total = 0.0;
    for (var controller in _amtControllers) {
      total += double.tryParse(controller.text) ?? 0.0;
    }
    return total;
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dt.year, dt.month, dt.day);

    if (date == today) {
      return 'Today,${DateFormat('hh:mm a').format(dt)}';
    } else {
      return DateFormat('dd-MM-yy ,hh:mm a').format(dt);
    }
  }

  void _selectDate(BuildContext ctx) async {
    final _today = DateTime.now();
    final pickedDate = await showDatePicker(
        context: ctx, firstDate: _today, lastDate: DateTime(_today.year + 1));
    setState(() {
      _isDateSelected = true;
      _date = pickedDate;
    });
  }

  void _selectTime(BuildContext ctx) async {
    final now = DateTime.now();
    final pickedTime =
        await showTimePicker(context: ctx, initialTime: TimeOfDay.now());
    setState(() {
      _isTimeSelected = true;
      _time = DateTime(
          now.year, now.month, now.day, pickedTime!.hour, pickedTime!.minute);
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      elevation: 4,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(151, 158, 158, 158)),
            borderRadius: BorderRadius.circular(12)),
        leading: Image.asset(
          widget.quotation.type == VehicleType.bike
              ? 'assets/images/r_bike.png'
              : 'assets/images/r_car.png',
          width: 40,
          height: 40,
        ),
        title: Text(
          '${widget.quotation.type == VehicleType.bike ? 'Bike' : 'Car'} Repair',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(_formatDateTime(widget.quotation.receivedAt)),
        children: [
          ClientProfile(client: widget.quotation.client),
          ListTile(
            title: Text(
              'Problem',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(widget.quotation.problem),
          ),
          ListTile(
            title: Text(
              'About Task',
              style: TextStyle(fontWeight: FontWeight.w600),
              softWrap: true,
            ),
            subtitle: Text(
              widget.quotation.aboutTask,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Date & Time',
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 31, maxWidth: 100),
                    width: 100,
                    height: 31,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 239, 110, 49),
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints.expand(),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 239, 110, 49),
                            ),
                            child: Center(
                              child: Text(
                                _isDateSelected
                                    ? DateFormat('E').format(_date!)
                                    : DateFormat('E').format(DateTime.now()),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          constraints: BoxConstraints.expand(),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 243, 238),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(_isDateSelected
                                ? DateFormat('dMMMM').format(_date!)
                                : DateFormat('dMMMM').format(DateTime.now())),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  height: 32,
                  width: 69,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 239, 110, 49),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        _isTimeSelected
                            ? DateFormat('hh:mm a').format(_time!)
                            : DateFormat('hh:mm a').format(DateTime.now()),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text(
              'Vehicle Images',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.quotation.vehicleImages.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor:
                                    Color.fromARGB(216, 240, 238, 238),
                                child: Stack(
                                  children: [
                                    Center(
                                        child: Container(
                                      height: 200,
                                      width: 200,
                                      child: Image.asset(
                                          fit: BoxFit.cover,
                                          widget
                                              .quotation.vehicleImages[index]),
                                    )),
                                    Positioned(
                                        top: 20,
                                        right: 18,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 194, 21, 8)),
                                          height: 40,
                                          width: 40,
                                          child: Center(
                                            child: IconButton(
                                                iconSize: 30,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Image.asset(
                              widget.quotation.vehicleImages[index]),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text(
                  'Bill Details',
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor:const Color.fromARGB(255, 239, 110, 49), ),
                  onPressed: addRow,
                  label: Text(
                    'Add Row',
                    style: TextStyle(color: const Color.fromARGB(255, 252, 249, 249)),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 245, 241, 238),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: DataTable(
                  border: TableBorder.symmetric(
                      outside: BorderSide(
                    color: Color.fromARGB(150, 0, 0, 1),
                  )),
                  columns: [
                    DataColumn(label: Text('Description',style: TextStyle(fontWeight: FontWeight.w600),)),
                    DataColumn(label: Text('Charges',style: TextStyle(fontWeight: FontWeight.w600)))
                  ],
                  rows: List.generate(
                    _rows.length,
                    (index) {
                      return DataRow(cells: [
                        DataCell(TextField(
                          controller: _descControllers[index],
                          onChanged: (value) {
                            setState(() {
                              _rows[index]['desc'] = value;
                            });
                          },
                        )),
                        DataCell(Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _amtControllers[index],
                            decoration: InputDecoration(
                                prefixText: '\$', border: OutlineInputBorder()),
                            onChanged: (value) {
                              setState(() {
                                _rows[index]['amt'] = value;
                              });
                            },
                          ),
                        ))
                      ]);
                    },
                  )),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${_calculateTotalAmount().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 49,
            width: 339,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 239, 110, 49),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                ref
                    .read(quotationListProvider.notifier)
                    .removeQuotation(widget.quotation);
              },
              child: const Text(
                'Send Quotation',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
