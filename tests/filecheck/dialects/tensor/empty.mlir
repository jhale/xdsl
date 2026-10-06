// RUN: XDSL_ROUNDTRIP
// RUN: XDSL_GENERIC_ROUNDTRIP

%index = "test.op"() : () -> index
%empty1 = tensor.empty(%index) : tensor<?x2xf32>
%empty2 = tensor.empty() {hello = "world"} : tensor<2x2xf32>

// CHECK: builtin.module {
// CHECK-NEXT:   %index = "test.op"() : () -> index
// CHECK-NEXT:   %empty1 = tensor.empty(%index) : tensor<?x2xf32>
// CHECK-NEXT:   %empty2 = tensor.empty() {hello = "world"} : tensor<2x2xf32>
// CHECK-NEXT: }

// CHECK-GENERIC: "builtin.module"() ({
// CHECK-GENERIC-NEXT:   %index = "test.op"() : () -> index
// CHECK-GENERIC-NEXT:   %empty1 = "tensor.empty"(%index) : (index) -> tensor<?x2xf32>
// CHECK-GENERIC-NEXT:   %empty2 = "tensor.empty"() {hello = "world"} : () -> tensor<2x2xf32>
// CHECK-GENERIC-NEXT: }) : () -> ()
