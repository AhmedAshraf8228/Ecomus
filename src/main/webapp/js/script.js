// document.addEventListener('DOMContentLoaded', () => {
//     document.querySelectorAll('.quantity-control').forEach(control => {
//         const minusBtn = control.querySelector('.btn-minus');
//         const plusBtn = control.querySelector('.btn-plus');
//         const quantitySpan = control.querySelector('span');

//         minusBtn.addEventListener('click', () => {
//             let quantity = parseInt(quantitySpan.textContent);
//             if (quantity > 1) {
//                 quantitySpan.textContent = quantity - 1;
//                 updateTotal();
//             }
//         });

//         plusBtn.addEventListener('click', () => {
//             let quantity = parseInt(quantitySpan.textContent);
//             quantitySpan.textContent = quantity + 1;
//             updateTotal();
//         });
//     });

//     document.querySelectorAll('.btn-remove').forEach(btn => {
//         btn.addEventListener('click', (e) => {
//             e.target.closest('.cart-item').remove();
//             updateTotal();
//         });
//     });

//     function updateTotal() {
//         const items = document.querySelectorAll('.cart-item');
//         let total = 0;
        
//         items.forEach(item => {
//             const price = parseFloat(item.querySelector('p:last-of-type').textContent.replace('$', '').trim());
//             const quantity = parseInt(item.querySelector('.quantity-control span').textContent);
//             total += price * quantity;
//         });

//         document.getElementById('totalPrice').textContent = `${total} $`;
//     }

 
//     updateTotal();
// });
