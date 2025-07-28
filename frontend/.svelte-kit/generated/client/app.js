export { matchers } from './matchers.js';

export const nodes = [
	() => import('./nodes/0'),
	() => import('./nodes/1'),
	() => import('./nodes/2'),
	() => import('./nodes/3'),
	() => import('./nodes/4'),
	() => import('./nodes/5'),
	() => import('./nodes/6'),
	() => import('./nodes/7'),
	() => import('./nodes/8'),
	() => import('./nodes/9'),
	() => import('./nodes/10'),
	() => import('./nodes/11'),
	() => import('./nodes/12'),
	() => import('./nodes/13'),
	() => import('./nodes/14'),
	() => import('./nodes/15'),
	() => import('./nodes/16'),
	() => import('./nodes/17'),
	() => import('./nodes/18'),
	() => import('./nodes/19'),
	() => import('./nodes/20'),
	() => import('./nodes/21'),
	() => import('./nodes/22'),
	() => import('./nodes/23'),
	() => import('./nodes/24')
];

export const server_loads = [];

export const dictionary = {
		"/": [2],
		"/courses/[slug]": [3],
		"/demos/component-library": [4],
		"/demos/data-science-path": [5],
		"/demos/data-science-path/components/achievement": [6],
		"/demos/data-science-path/components/data-cleaning": [7],
		"/demos/data-science-path/components/data-collection": [8],
		"/demos/data-science-path/components/data-exploration": [9],
		"/demos/data-science-path/components/data-types": [10],
		"/demos/data-science-path/components/fundamentals-quiz": [11],
		"/demos/data-science-path/components/intro-quiz": [12],
		"/demos/data-science-path/components/milestone": [13],
		"/demos/data-science-path/components/setup": [14],
		"/demos/data-science-path/components/welcome": [15],
		"/demos/data-science-path/example-course-lobby": [16],
		"/demos/regression": [17],
		"/demos/regression/section-1": [18],
		"/demos/regression/section-2": [19],
		"/demos/regression/section-3": [20],
		"/demos/regression/section-4": [21],
		"/demos/regression/section-5": [22],
		"/room/[id]": [23],
		"/signup": [24]
	};

export const hooks = {
	handleError: (({ error }) => { console.error(error) }),
	
	reroute: (() => {}),
	transport: {}
};

export const decoders = Object.fromEntries(Object.entries(hooks.transport).map(([k, v]) => [k, v.decode]));

export const hash = false;

export const decode = (type, value) => decoders[type](value);

export { default as root } from '../root.js';