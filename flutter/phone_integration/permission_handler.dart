import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler extends StatefulWidget {
  PermissionHandler({Key key}) : super(key: key);

  @override
  _PermissionHandlerState createState() => _PermissionHandlerState();
}

class _PermissionHandlerState extends State<PermissionHandler> {

///` uninstall and build again while working with device permissions. Don't forget to add permissions on AndroidManifest.xml(android) and info.plist(iso) `

  String permission_status;
  Permission permission;

  @override
  void initState() {
    permission_status = "";
    super.initState();
  }

  // just preview that can archive with permissionhandler
  void _showPermissions() {
    var _permissionsCanArchive = Permission.values;
    log("type: ${_permissionsCanArchive.runtimeType} total: ${_permissionsCanArchive.length}\n >>");
    _permissionsCanArchive.forEach((Permission permission) {
      log(permission.toString());
    });
  }

  Future<void> _requestpermission() async {
    PermissionStatus result = await permission.request();
    log("requesting....$permission");
    setState(() =>
        permission_status = "${permission.toString()}: ${result.toString()}");
  }

  //from Doc
  void checkServiceStatus(BuildContext context) async {
    log(permission.toString());
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text((await permission.status).toString()),
    ));
  }

  Future<void> _checkPermission() async {
    var status = await permission.status;
    log(" per-status: $status");
    setState(() {
      permission_status = "${permission.toString()}: $status";
    });
  }

  getPermissionStatus() async {
    log(await permission.status.toString());
    var status = await permission.status;
    setState(() =>
        permission_status = "${permission.toString()}: $status");
  }

  onDropDownChange(Permission _permission) {
    setState(() {
      this.permission = _permission;
      permission_status = "Click a button bellow";
    });
    log("On Select permission: ${_permission}");
  }

  List<DropdownMenuItem<Permission>> _getDropDownItems() {
    List<DropdownMenuItem<Permission>> items =
        new List<DropdownMenuItem<Permission>>();
    Permission.values.forEach((permission) {
      var item = new DropdownMenuItem(
        child: new Text((permission.toString())),
        value: permission,
      );
      items.add(item);
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Text(
                "${permission_status}",
                style: TextStyle(fontSize: 23),
              ),
            ),
            DropdownButton(
              items: _getDropDownItems(),
              value: permission,
              onChanged: onDropDownChange,
            ),
            RaisedButton(
              onPressed: _showPermissions,
              child: Text("All PermissionS"),
            ),
            RaisedButton(
              onPressed: _checkPermission,
              child: Text("Check Permission"),
            ),
            RaisedButton(
              onPressed: _requestpermission,
              child: Text("Request Permission"),
            ),
            RaisedButton(
              onPressed: getPermissionStatus,
              child: Text("Get Status"),
            ),
            RaisedButton(
              onPressed: openAppSettings,
              child: Text("Open Settings later"),
            ),
          ],
        ),
      ),
    );
  }

}
