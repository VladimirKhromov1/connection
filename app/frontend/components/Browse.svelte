<script lang="ts">
    import type {Account} from "../store/AccountStore";

    export let accounts: Account
</script>

{#each accounts as account, index }
    <div class="wel-{index}">{account.email}</div>
{/each}

<style>

</style>