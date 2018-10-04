/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

jQuery.validator.setDefaults({
  debug: true,
  success: "valid"
});

$( "#budget_form" ).validate({
  rules: {
    budget_val: {
      required: true,
      digits: true
    }
  }
});