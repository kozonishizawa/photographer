import Sortable from 'sortablejs';
import Xhr from '../lib/xhr';

var contact_status_list = document.getElementById('sortable_list');
var sortable = new Sortable(contact_status_list, {
  animation: 150,
  ghostClass: 'blue-background-class',
  onUpdate: evt => {
    var after_position = { after_position: evt.newIndex }
    Xhr.request.patch(`/admin/sort_contact_statuses/${evt.clone.dataset.id}`, after_position)
  }
});