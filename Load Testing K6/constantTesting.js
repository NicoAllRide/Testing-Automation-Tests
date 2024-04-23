import { sleep, check } from "k6";
import http from "k6/http";

export const options = {
	ext: {
		loadimpact: {
			distribution: {
				"amazon:us:ashburn": { loadZone: "amazon:us:ashburn", percent: 100 },
			},
			apm: [],
		},
	},
	thresholds: {},
	scenarios: {
		Scenario_1: {
			executor: "constant-vus",
			gracefulStop: "30s",
			duration: "1m",
			vus: 1,
			exec: "scenario_1",
		},
	},
};

export function scenario_1() {
	let response;

	response = http.post(
		"https://testing.allrideapp.com/api/v1/admin/appMessaging/send?community=5a906201d0c7684ad80e2ec6",
		'{\n  "pushNotification": {\n    "title": "Backend Test",\n    "content": "Contenido de la notificacion."\n  },\n  "fullMessage": {\n    "title": "Prueba de mensaje masivo backend",\n    "content": "Este es un mensaje que.",\n    "image": "https://s3.amazonaws.com/allride.uploads/communityAvatar_5a906201d0c7684ad80e2ec7_1685041549338.png",\n    "cta": "pb_map",\n    "buttonText": "Rutas alternativas",\n    "externalURL": "www.prueba.cl/{{communityId}}/{{userId}}"\n  },\n  "destinataries": "communityMembers"\n}',
		{
			headers: {
				Authorization:
					"Bearer d308e03b814596fb9f646e39792deab2f36781cf7d311a55e85509c51d919d3c6bd76395e43ebff08101c59ee1a3ff4dd9837d39fa9beb0473a5f3df74bb793d",
				"content-type": "application/json",
			},
		}
	);
	check(response, {
		"status equals 200": (response) => response.status.toString() === "200",
		"status does not contain 200": (response) =>
			!response.status.toString().includes("200"),
	});

	// Automatically added sleep
	sleep(1);
}
