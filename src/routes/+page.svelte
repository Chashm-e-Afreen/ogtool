<script>
	import Sidebar from '$lib/components/Sidebar.svelte';
	import Feed from '$lib/components/Feed.svelte';
</script>

<div class="min-h-screen bg-gray-50 text-gray-900 transition-colors duration-500">
	<main class="mx-auto grid max-w-7xl grid-cols-1 gap-8 px-6 py-8 lg:grid-cols-12">
		<Sidebar />
		<Feed />
	</main>
</div>
