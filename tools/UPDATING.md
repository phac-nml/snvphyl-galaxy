# Update to SNVPhyl 1.0

See [SNVPhyl Upgrade](http://snvphyl.readthedocs.org/en/latest/developer/upgrading/) documentation for additinal details.

1. Add package_snvphyl_1_7

    ```
    planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'update to 1.7'  tools/package_snvphyl
    ```

2. Upload additional capsules.

    * capsule_toolshed.g2.bx.psu.edu_package_bcftools_1_3_iuc_43a9aebf3adb.tar.gz
    * capsule_toolshed.g2.bx.psu.edu_collapse_collections_nml_49bd84e136c7.tar.gz

3. Add additional tools.

    ```
    for i in tools/snvphyl-tools/snv_matrix tools/snvphyl-tools/consolidate_vcfs tools/snvphyl-tools/vcf2snvalignment tools/snvphyl-tools/filter_density;
    do
        planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'install 1.7' $i
    done
    ```

4. Update remaining tools.

    ```
    ./scripts/run_planemo_for_tools.sh shed_update --shed_target http://localhost:9009 --shed_key KEY --message 'update_1.0'
    ```

5. Install Tool Suite

    ```
    planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'update to 1.0'  tools/suite_snvphyl
    ```
