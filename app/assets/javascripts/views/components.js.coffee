App.MenuItem = Ember.View.extend
  templateName: 'components/menu_item'
  tagName: 'a'
  classNames: ['btn']
  attributeBindings: ['href', 'hidden']
  # hidden: 'hidden'

