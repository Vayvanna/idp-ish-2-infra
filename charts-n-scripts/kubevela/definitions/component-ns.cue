"tenant-ns": {
    attributes: {
        // We do NOT define a workload definition here.
        // This tells KubeVela to handle this as a 'k8s-objects' type
        // which is much more lenient with dry-run checks.
    }
    type: "component"
}

template: {
    // We move the Namespace to outputs so it's treated as a generic object
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