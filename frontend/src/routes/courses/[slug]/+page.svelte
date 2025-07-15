<script>
  import CoursePage from '../../../components/CoursePage.svelte';
  import { page } from '$app/stores';
  $: slug = $page.params.slug;
</script>

<CoursePage slug={slug} /> 