import { Ref } from "nuxt/dist/app/compat/capi";

export const useFlagStore = () => {
    const flag = useState("flag", () => (false))
    return {
        flag: readonly(flag),
        setFlag: setFlag(flag),
        deleteTodo: deleteTodo(flag)
    };
};

const setFlag = (flag: Ref<boolean>) => (val: boolean) => { flag.value = val };

const deleteTodo = (flag: Ref<boolean>) => (num: string) => {
    const currentUrl = window.location.href
    const pending = useFetch(currentUrl + 'api/todos/' + num, { method: "delete", })
    flag.value = true
};
