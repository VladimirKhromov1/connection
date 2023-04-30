<script lang="ts">
    import type {Account} from "../store/AccountStore";
    import {faMapMarker} from "@fortawesome/free-solid-svg-icons";
    import Fa from 'svelte-fa'

    export let account: Account
</script>

<div class="profile">
    <h1 class="title">{account.firstName} {account.lastName}</h1>
    <div><span class="text">Username:</span> <span class="text">{account.username}</span></div>
    <div><span class="text">Age:</span> <span class="text">{account.age}</span></div>
    <div><Fa icon={faMapMarker}  /> <span class="text">{account.country},{account.city}</span></div>
</div>

<style>
    .title {
        margin-bottom: 3rem;
        color: #86f60c;
    }
    .text {
        font-size: 20px;
    }
    .profile {
        display: flex;
        flex-direction: column;
        margin-left: -1rem;
    }
</style>