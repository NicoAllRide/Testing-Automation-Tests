//-------------------------RAMPING TESTING----------------------------------------/// 

import { sleep } from 'k6'
import http from 'k6/http'

export const options = {
  ext: {
    loadimpact: {
      distribution: { 'amazon:us:ashburn': { loadZone: 'amazon:us:ashburn', percent: 100 } },
      apm: [],
    },
  },
  thresholds: {},
  scenarios: {
    Scenario_1: {
      executor: 'ramping-vus',
      gracefulStop: '30s',
      stages: [
        { target: 100, duration: '1m' },
        { target: 100, duration: '3m30s' },
        { target: 0, duration: '1m' },
      ],
      gracefulRampDown: '30s',
      exec: 'scenario_1',
    },
  },
}

export function scenario_1() {
  let response

  // Performance Allride Testing
  response = http.post(
    'https://testing.allrideapp.com/api/v1/admin/appMessaging/send?community=5a906201d0c7684ad80e2ec6',
    '{\r\n   "pushNotification":{\r\n      "title":"Backend Test",\r\n      "content":"Contenido de la notificacion."\r\n   },\r\n   "fullMessage":{\r\n      "title":"Prueba de mensaje masivo backend",\r\n      "content":"Este es un mensaje que.",\r\n      "image":"https://s3.amazonaws.com/allride.uploads/communityAvatar_5a906201d0c7684ad80e2ec7_1685041549338.png",\r\n      "cta":"pb_map",\r\n      "buttonText":"Rutas alternativas",\r\n      "externalURL":"www.prueba.cl/{{communityId}}/{{userId}}"\r\n   },\r\n   "destinataries":"communityMembers"\r\n}',
    {
      headers: {
        Authorization:
          'Bearer d308e03b814596fb9f646e39792deab2f36781cf7d311a55e85509c51d919d3c6bd76395e43ebff08101c59ee1a3ff4dd9837d39fa9beb0473a5f3df74bb793d',
        'content-type': 'application/json',
      },
    }
  )

  // Automatically added sleep
  sleep(1)
}
