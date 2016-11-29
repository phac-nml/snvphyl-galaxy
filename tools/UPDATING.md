# Update to SNVPhyl 1.0.1

See [SNVPhyl Upgrade](http://snvphyl.readthedocs.io/en/latest/developer/upgrading/) documentation for additinal details.

1. Add package_snvphyl_1_8_0

    ```
    planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'update'  tools/package_snvphyl
    ```

2. Add additional tools.

    ```
    for i in tools/snvphyl-tools/positions2snv_alignment tools/snvphyl-tools/positions2snv_invariant_alignment;
    do
        planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'install' $i
    done
    ```

3. Update remaining tools.

    ```
    ./scripts/run_planemo_for_tools.sh shed_update --shed_target http://localhost:9009 --shed_key KEY --message 'update'
    ```

4. Install Tool Suite

    ```
    planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'update'  tools/suite_snvphyl
    ```
