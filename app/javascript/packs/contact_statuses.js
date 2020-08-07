import Sortable from 'sortablejs';
import Xhr from '../lib/xhr';

var contactStatusList = document.getElementById('sortable_list');
var sortable = new Sortable(contactStatusList, {
  animation: 150,
  ghostClass: 'blue-background-class',
  onUpdate: evt => {
    var newPosition = { new_position: evt.newIndex }
    Xhr.request.patch(`/admin/sort_contact_statuses/${evt.clone.dataset.id}`, newPosition);
  }
});