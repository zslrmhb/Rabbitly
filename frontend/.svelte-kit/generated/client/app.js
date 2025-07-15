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
	() => import('./nodes/21')
];

export const server_loads = [];

export const dictionary = {
		"/": [2],
		"/courses": [4],
		"/courses/[slug]": [5],
		"/course/[id]": [3],
		"/demos/data-science-path": [6],
		"/demos/data-science-path/components/achievement": [7],
		"/demos/data-science-path/components/data-cleaning": [8],
		"/demos/data-science-path/components/data-collection": [9],
		"/demos/data-science-path/components/data-exploration": [10],
		"/demos/data-science-path/components/data-types": [11],
		"/demos/data-science-path/components/fundamentals-quiz": [12],
		"/demos/data-science-path/components/intro-quiz": [13],
		"/demos/data-science-path/components/milestone": [14],
		"/demos/data-science-path/components/setup": [15],
		"/demos/data-science-path/components/welcome": [16],
		"/demos/learning-path": [17],
		"/demos/learning-path/components/code-1": [18],
		"/demos/learning-path/components/mcq-1": [19],
		"/demos/learning-path/components/text-1": [20],
		"/room/[id]": [21]
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