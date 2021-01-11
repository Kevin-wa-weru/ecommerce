const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


//START

// void main(List<String> args) {
//     var data = Get_data_From_User();
//     var set_data = data.Get_data();
  
//     var On_Proceeding = On_Proceed(set_data['Depot_id'],
//         set_data['Shippment plan'], set_data['Date of day']);
//     var FD_users = On_Proceeding.Determine_Shippment_Plan();
//     print(FD_users);
  
//     return null;
//   }
//   // CLOUD FUNCTION TO BE TRIGGERED
//   class Get_data_From_User {
//     Map Get_data() {
//       //  Receive user data
//       var Action = {
//         'Depot_id': '4',
//         'Shippment plan': 'FD',
//         'Date of day': '12/12/2020',
//       };
  
//       return (Action);
//     }
//   }
//   //STEP 2--AFTER GETTING DATA FROM THE USER
//   class On_Proceed {
//     final depot_id;
//     final shippment_plan;
//     final delivery_date;
//     On_Proceed(this.depot_id, this.shippment_plan, this.delivery_date);
//   //DETERMINING THE SHIPPMENT PLAN
//     String Determine_Shippment_Plan() {
//       var FX;
//       switch (shippment_plan) {
//         case 'FD':
//           //query database to see the applied fee for the depot_id and pass the result to a variable FX.
//           FX = 300;
//           return ('message to user: The delivery fee is :$FX');
//           break;
//         case 'CS':
//           return (it_is_CS_execute_this());
//           break;
//         default:
//           return ('no shippment plan received'); /*****************************/
//       }
//     }
//   //EXECUTE THIS IF THE USER HAS CHOSEN TO SHARE COST WITH OTHER USERS.
//     String it_is_CS_execute_this() {
//       var R;
//       var F;
//       var G;
  
//       //query database for similar order  --> matching depot_id && shippment type of CS && shared cost status(N) && similar date of delivery
//       //and pass the result(true or false) to a variable G.
//       if (G == true) {
//         //query database to take a limit of one similar order sorting by id and pass the result(order id) to a variable as order K.
//         //Query the database to update the status  on Shared Cost Status of order K as pending(P)
//         //query database to take fixed price of the depot id and pass the result to a variable F.
//         R = F / 2;
//         return ('message to user: The applicable delivery fee is: $R'); /******************/
//       } else {
//         //incase G==FALSE
//         return ('message to user: No similar depot found'); /******************/
//       }
//     }
//   }
  
  // END
  