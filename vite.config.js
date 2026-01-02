import tailwindcss from '@tailwindcss/vite';
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig, searchForWorkspaceRoot } from 'vite';

export default defineConfig({
	plugins: [tailwindcss(), sveltekit()],
	server: {
		fs: {
			allow: [searchForWorkspaceRoot(process.cwd()), './output']
		},
		allowedHosts: true
	},
	preview: {
		allowedHosts: true
	}
});
