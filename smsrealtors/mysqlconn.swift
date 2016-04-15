//
//  mysqlconn.swift
//  smsrealtors
//
//  Created by Bill Banks on 2/24/16.
//  Copyright © 2016 Bill Banks. All rights reserved.
//

import Foundation
//import MySqlSwiftNative

let HOST = "sms.ourweb.net"
let MYSQLUN = "root"
let MYSQLPW = "132313"
let MYSQLDB = "oursmsserver"

let conn = MySQL.Connection()

var userdata  = user()

func opendb(){
do{
   try conn.open(HOST, user: MYSQLUN, passwd: MYSQLPW, dbname: MYSQLDB)
}
catch (let err) {
    print(err)
}
}

    func closedb() {
        do{
            try conn.close()
        }
        catch (let err) {
            print(err)
        }
    }
    