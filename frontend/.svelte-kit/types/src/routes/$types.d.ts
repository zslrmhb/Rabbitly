import type * as Kit from '@sveltejs/kit';

type Expand<T> = T extends infer O ? { [K in keyof O]: O[K] } : never;
// @ts-ignore
type MatcherParam<M> = M extends (param : string) => param is infer U ? U extends string ? U : string : string;
type RouteParams = {  };
type RouteId = '/';
type MaybeWithVoid<T> = {} extends T ? T | void : T;
export type RequiredKeys<T> = { [K in keyof T]-?: {} extends { [P in K]: T[K] } ? never : K; }[keyof T];
type OutputDataShape<T> = MaybeWithVoid<Omit<App.PageData, RequiredKeys<T>> & Partial<Pick<App.PageData, keyof T & keyof App.PageData>> & Record<string, any>>
type EnsureDefined<T> = T extends null | undefined ? {} : T;
type OptionalUnion<U extends Record<string, any>, A extends keyof U = U extends U ? keyof U : never> = U extends unknown ? { [P in Exclude<A, keyof U>]?: never } & U : never;
export type Snapshot<T = any> = Kit.Snapshot<T>;
type PageParentData = EnsureDefined<LayoutData>;
type LayoutRouteId = RouteId | "/" | "/course/[id]" | "/courses" | "/courses/[slug]" | "/demos/data-science-path" | "/demos/data-science-path/components/achievement" | "/demos/data-science-path/components/data-cleaning" | "/demos/data-science-path/components/data-collection" | "/demos/data-science-path/components/data-exploration" | "/demos/data-science-path/components/data-types" | "/demos/data-science-path/components/fundamentals-quiz" | "/demos/data-science-path/components/intro-quiz" | "/demos/data-science-path/components/milestone" | "/demos/data-science-path/components/setup" | "/demos/data-science-path/components/welcome" | "/demos/learning-path" | "/demos/learning-path/components/code-1" | "/demos/learning-path/components/mcq-1" | "/demos/learning-path/components/text-1" | "/room/[id]" | null
type LayoutParams = RouteParams & { id?: string; slug?: string }
type LayoutParentData = EnsureDefined<{}>;

export type PageServerData = null;
export type PageData = Expand<PageParentData>;
export type PageProps = { data: PageData }
export type LayoutServerData = null;
export type LayoutData = Expand<LayoutParentData>;
export type LayoutProps = { data: LayoutData; children: import("svelte").Snippet }