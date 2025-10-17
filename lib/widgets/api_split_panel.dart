import 'package:dashboard/widgets/customcontrols/key_value_reactive_dropdown.dart';
import 'package:dashboard/widgets/customcontrols/key_value_reactive_textbox.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
 
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SplitPanel());
  }
}
 
class SplitPanel extends StatefulWidget {
  final int columns;
  final double itemSpacing;
  const SplitPanel({super.key, this.columns = 2, this.itemSpacing = 2.0});
 
  @override
  State<SplitPanel> createState() => _SplitPanelState();
}
 
class _SplitPanelState extends State<SplitPanel> {
  List<Map<String, dynamic>> createdApis = [];
 
  final form = FormGroup({
    'apiName': FormControl<String>(validators: [Validators.required]),
    'apiEndpoint': FormControl<String>(validators: [Validators.required]),
    'apiMethodName': FormControl<String>(),
    'httpMethod': FormControl<String>(validators: [Validators.required]),
    'headers': FormArray([]),
    'requestKey': FormArray([]),
  });
 
  final headerEntryForm = FormGroup({
    'key': FormControl<String>(validators: [Validators.required]),
    'value': FormControl<String>(validators: [Validators.required]),
  });
 
  final requestEntryForm = FormGroup({
    'key': FormControl<String>(validators: [Validators.required]),
    'value': FormControl<String>(),
  });
 
  String searchQuery = "";
 
  void _saveApi() {
    if (form.valid) {
      final json = form.value;
      setState(() {
        createdApis.add(Map<String, dynamic>.from(json));
      });
      debugPrint("Saved API JSON: $json");
 
      form.reset();
      (form.control('headers') as FormArray).clear();
      (form.control('requestKey') as FormArray).clear();
      headerEntryForm.reset();
      requestEntryForm.reset();
    } else {
      form.markAllAsTouched();
    }
  }
 
  void _editApi(int index) {
    final api = createdApis[index];
 
    form.reset();
    form.patchValue({
      'apiName': api['apiName'],
      'apiEndpoint': api['apiEndpoint'],
      'apiMethodName': api['apiMethodName'],
      'httpMethod': api['httpMethod'],
    });
 
    final headersArray = form.control('headers') as FormArray;
    headersArray.clear();
    if (api['headers'] != null) {
      for (var h in api['headers']) {
        headersArray.add(FormGroup({
          'key': FormControl<String>(value: h['key']),
          'value': FormControl<String>(value: h['value']),
        }));
      }
    }
 
    final requestArray = form.control('requestKey') as FormArray;
    requestArray.clear();
    if (api['requestKey'] != null) {
      for (var r in api['requestKey']) {
        requestArray.add(FormGroup({
          'key': FormControl<String>(value: r['key']),
          'value': FormControl<String>(value: r['value']),
        }));
      }
    }
    setState(() {});
  }
 
  void _deleteApi(int index) {
    setState(() {
      createdApis.removeAt(index);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Builder'), elevation: 2),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final panelWidth = constraints.maxWidth / 3;
          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 4, right: 8),
            child: Stack(
              children: [
                // LEFT PANEL
                Positioned(
                  width: panelWidth - 50,
                  height: constraints.maxHeight,
                  left: 0,
                  child: _buildLeftPanel(),
                ),
                // CENTER PANEL
                Positioned(
                  width: panelWidth + 100,
                  height: constraints.maxHeight,
                  left: panelWidth - 50,
                  child: _buildCenterPanel(),
                ),
                // RIGHT PANEL (NEW)
                Positioned(
                  width: panelWidth,
                  height: constraints.maxHeight,
                  left: (panelWidth * 2) + 50,
                  child: _buildRightPanel(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
 
  // ====== LEFT PANEL ======
  Widget _buildLeftPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (val) => setState(() => searchQuery = val.toLowerCase()),
            decoration: InputDecoration(
              hintText: "Search....",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: createdApis
                .where((api) =>
                    api['apiName']
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery) ||
                    api['apiEndpoint']
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery))
                .length,
            itemBuilder: (context, index) {
              final filteredApis = createdApis
                  .where((api) =>
                      api['apiName']
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery) ||
                      api['apiEndpoint']
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery))
                  .toList();
 
              final api = filteredApis[index];
 
              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(api['apiName']),
                  subtitle: Text(api['apiEndpoint']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editApi(createdApis.indexOf(api)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteApi(createdApis.indexOf(api)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
 
  // ====== CENTER PANEL ======
  Widget _buildCenterPanel() {
    return SingleChildScrollView(
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildApiInputs(),
            _buildHeaderSection(),
            _buildRequestKeySection(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Test API",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveApi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text("SAVE",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  // ====== RIGHT PANEL (JSON STRUCTURED VIEW) ======
  Widget _buildRightPanel() {
    final headersArray = form.control('headers') as FormArray;
    final requestArray = form.control('requestKey') as FormArray;
 
    Map<String, String> headersObject = {
      for (var h in headersArray.controls)
        if ((h as FormGroup).control('key').value != null &&
            (h).control('value').value != null)
          h.control('key').value: h.control('value').value,
    };
 
    Map<String, String> requestObject = {
      for (var r in requestArray.controls)
        if ((r as FormGroup).control('key').value != null)
          r.control('key').value: r.control('value').value ?? "",
    };
 
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Structured View",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
 
            Text("Headers Object:",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 6, bottom: 12),
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Text(
                _formatAsJson(headersObject),
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
 
            Text("Request Object:",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Text(
                _formatAsJson(requestObject),
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  String _formatAsJson(Map<String, dynamic> obj) {
    return obj.isEmpty
        ? "{}"
        : "{\n${obj.entries.map((e) => '\"${e.key}\": \"${e.value}\"').join(',\n')}\n}";
  }
 
  // ====== COMMON UI SECTIONS ======
  Widget _buildApiInputs() {
    return Column(
      children: [
        Padding(
             padding: const EdgeInsets.symmetric(vertical: 6),
          child: KeyValueReactiveTextbox(
            labeltext: 'API name',
            width: 500,
            formControlName: 'apiName',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: KeyValueReactiveTextbox(
            labeltext: 'API Endpoint(URL)',
            width: 500,
            formControlName: 'apiEndpoint',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: KeyValueReactiveTextbox(
            labeltext: 'API method name',
            width: 500,
            formControlName: 'apiMethodName',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: KeyValueReactiveDropdown(
            width: 500,
            labeltext: 'HTTP method',
            dropdownEntries: ['POST', 'GET', 'PUT', 'DELETE'],
            formControlName: 'httpMethod',
          ),
        ),
      ],
    );
  }
 
  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Headers", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ReactiveForm(
            formGroup: headerEntryForm,
            child: Column(
              children: [
                KeyValueReactiveTextbox(
                  formControlName: 'key',
                  labeltext: 'Header Key',
                  width: 500,
                ),
                const SizedBox(height: 8),
                KeyValueReactiveTextbox(
                  formControlName: 'value',
                  labeltext: 'Header Value',
                  width: 500,
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    if (headerEntryForm.valid) {
                      final headersArray =
                          form.control('headers') as FormArray;
                      headersArray.add(FormGroup({
                        'key': FormControl<String>(
                            value: headerEntryForm.control('key').value),
                        'value': FormControl<String>(
                            value: headerEntryForm.control('value').value),
                      }));
                      headerEntryForm.reset();
                      setState(() {});
                    } else {
                      headerEntryForm.markAllAsTouched();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildRequestKeySection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Request Keys", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ReactiveForm(
            formGroup: requestEntryForm,
            child: Column(
              children: [
                KeyValueReactiveTextbox(
                  formControlName: 'key',
                  labeltext: 'Request Key',
                  width: 500,
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    if (requestEntryForm.valid) {
                      final requestArray =
                          form.control('requestKey') as FormArray;
                      requestArray.add(FormGroup({
                        'key': FormControl<String>(
                            value: requestEntryForm.control('key').value),
                        'value': FormControl<String>(value: ""),
                      }));
                      requestEntryForm.reset();
                      setState(() {});
                    } else {
                      requestEntryForm.markAllAsTouched();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}