// test_script.js

import http from 'k6/http';
import { sleep } from 'k6';

export default function () {
  http.get('https://api.example.com/endpoint');
  sleep(1);
}
