// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '/jh_common/utils/jh_image_utils.dart';
import '/jh_common/widgets/jh_dialog.dart';
import '/project/configs/project_config.dart';

class ListviewDragSortPage extends StatefulWidget {
  const ListviewDragSortPage({Key? key}) : super(key: key);

  @override
  State<ListviewDragSortPage> createState() => _ListviewDragSortPageState();
}

class _ListviewDragSortPageState extends State<ListviewDragSortPage> {
  List _originList = [];
  List _mList = [];
  bool _isSort = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var i = 0; i < 30; i++) {
      var dict = {'id': i, 'name': i.toString()};
      _mList.add(dict);
    }
    _originList = List.from(_mList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar('ListviewDragSortPage'),
      body: _body(),
      // backgroundColor: KColors.kBgColor,
    );
  }

  Widget _body() {
    return ReorderableListView(
      header: _header(),
      onReorder: _onReorder,
      children: _mList.map((e) => _cell(e)).toList(),
      // proxyDecorator: (widget, index, animation) {
      //   return Container(color: Colors.white, child: widget);
      // },
    );
  }

  _onReorder(int oldIndex, int newIndex) {
    // print('oldIndex: $oldIndex , newIndex: $newIndex');
    setState(() {
      _isSort = true;
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      var item = _mList.removeAt(oldIndex);
      _mList.insert(newIndex, item);
    });
  }

  Widget _cell(item) {
    return Container(
      key: ValueKey(item['name']),
      height: 50,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('name:  ${item['name']}'),
          const Icon(Icons.menu),
        ],
      ),
    );
  }

  Widget _header() {
    return InkWell(
      onTap: () {
        setState(() {
          if (!_isSort) {
            _isSort = !_isSort;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 8),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: Colors.white,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Click to sort'),
            // Icon(Icons.sort),
            !_isSort
                ? const JhAssetImage('ic_sort', width: 22, height: 22, color: Colors.black)
                : Row(
                    children: [
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text('Cancel', style: KStyles.textWhite14),
                        ),
                        onTap: () {
                          setState(() {
                            if (_isSort) {
                              _mList = List.from(_originList);
                              _isSort = !_isSort;
                            }
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text('Complete', style: KStyles.textWhite14),
                        ),
                        onTap: () => _onSubmit(),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  _onSubmit() {
    var title = 'Are you sure you want to submit?';
    JhDialog.show(
      context,
      content: title,
      leftText: 'Cancel',
      rightText: 'Confirm',
      onConfirm: () => _submitRequest(),
    );
  }

  _submitRequest() {
    print('_mList: $_mList');

    var params = [];
    for (var i = 0; i < _mList.length; i++) {
      var item = _mList[i];
      params.add({
        'id': item['id'],
        'sort': i + 1,
      });
    }
    print('params: $params');

    JhProgressHUD.showLoadingText('Submitting...');
    Future.delayed(const Duration(milliseconds: 1500), () {
      JhProgressHUD.hide();
      JhProgressHUD.showSuccess('Submitted successfully');
      Future.delayed(const Duration(seconds: 1), () {
        JhNavUtils.goBack(context);
      });
    });
  }
}
