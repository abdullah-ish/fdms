document.addEventListener('DOMContentLoaded', function () {
  const alerts = document.querySelectorAll('[data-auto-dismiss="true"]');
  alerts.forEach(alert => {
    setTimeout(() => {
      alert.classList.remove('show');
      alert.classList.add('fade');
      alert.style.display = 'none';
    }, 3000);  // Adjust time to 3 seconds (3000 ms)
  });
});

  $(document).ready(function() {
    // $('#fdms-datatable').dataTable();
    if ( $.fn.dataTable.isDataTable( '#fdms-datatable' ) ) {
      table = $('#fdms-datatable').DataTable();
    }
    else {
      table = $('#fdms-datatable').DataTable( {
        // paging: false
        ordering: false,
      } );
    }

});

console.log("Flash messages auto-dismiss active!");
