import 'jquery-ujs/src/rails';
import 'bootstrap/dist/js/bootstrap';
import './alert';
import Graph from './graph';

window.$ = window.jQuery = require('jquery');
window.scroll = require('./scroll').default;
window.graph = Graph;
