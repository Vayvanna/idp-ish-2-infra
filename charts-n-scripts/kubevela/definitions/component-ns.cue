"tenant-ns": {
    attributes: {}
    type: "component"
}

template: {
    // This dummy output satisfies the 'apply-component' requirement 
    // without triggering namespace-scoped validation dry-runs.
    output: {
        apiVersion: "v1"
        kind:       "ConfigMap"
        metadata: {
            name:      context.name + "-setup-anchor"
            namespace: "vela-system"
        }
        data: "info": "Anchor for tenant " + context.name
    }
    outputs: {
        ns: {
            apiVersion: "v1"
            kind:       "Namespace"
            metadata: name: context.name
        }
        quota: {
            apiVersion: "v1"
            kind:       "ResourceQuota"
            metadata: {
                name:      context.name + "-quota"
                namespace: context.name
            }
            spec: hard: {
                "cpu":    parameter.cpu
                "memory": parameter.memory
                "pods":   parameter.pods
            }
        }
    }
    parameter: {
        cpu:    * "2" | string
        memory: * "4Gi" | string
        pods:   * "10" | string
    }
}