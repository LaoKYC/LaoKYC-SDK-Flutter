import 'dart:async';

class CheckValid {
  checkValidPhonenumber(String phonenumber) {
    if (phonenumber.startsWith('20') == true) {
      if (phonenumber.length == 10) {
        if (phonenumber.startsWith('202')) {
          return true;
        } else if (phonenumber.startsWith('203')) {
          return true;
        } else if (phonenumber.startsWith('205')) {
          return true;
        } else if (phonenumber.startsWith('206')) {
          return true;
        } else if (phonenumber.startsWith('207')) {
          return true;
        } else if (phonenumber.startsWith('208')) {
          return true;
        } else if (phonenumber.startsWith('209')) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else if (phonenumber.startsWith('30') == true) {
      if (phonenumber.length == 9) {
        if (phonenumber.startsWith('302')) {
          return true;
        } else if (phonenumber.startsWith('304')) {
          return true;
        } else if (phonenumber.startsWith('305')) {
          return true;
        } else if (phonenumber.startsWith('307')) {
          return true;
        } else if (phonenumber.startsWith('309')) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
